# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  event_date :datetime
#  address    :string
#  capacity   :integer          default(0)
#  available  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  progress   :integer          default(0)
#  message    :text
#
class Event < ApplicationRecord
   # where(available: false).paginate(page: params[:page], per_page: 6).order("id DESC")
   #where(available: true).where(event_date: current_date..(current_date + 10.days) )
   current_date = Date.today
    require 'date'
    #associations
    belongs_to :user
    has_many :guests, dependent: :destroy

    #validations
    validates :name, presence: true
    validates :address, presence: true 
    validates :event_date, presence: true
    #callbacks
    before_create :capitalize_name
    #broadcast Sockets
    after_commit {broadcast_refresh_to :events_list}
    after_commit {broadcast_refresh_to :event}
    #scopes
    scope :closed, -> {where(available: false)}
    scope :upcoming_events, ->{where(available: true).where(event_date: current_date..(current_date + 10.days) )}
    
    def format_date 
        if self.event_date
            parse_date = DateTime.parse(self.event_date.to_s)
            formated_date = parse_date.strftime("%e %^b  %Y")
            #EVENT_HOURS = parse_date.strftime("%H %M")

            return formated_date
        end 
    end
     def close_event
        current_time = Time.now 
        time_to_close = Date.parse(self.event_date.to_s) if self.event_date

        if !self.event_date  || current_time >= time_to_close  || self.capacity <= 0
            self.available = false
        else
            self.available = true
           
        end
        self.save
     end

     def calculate_progress(p = 0)
        participants = p.to_f
        porcentage = (participants / self.capacity) * 100
        if self.progress != 100 || self.capacity > 0
                self.progress += (porcentage.abs - self.progress)
                self.capacity -= participants
                self.save
        end
     end

     def return_progress 
        return self.progress
     end
     
     def return_status 
       if self.progress == 100 
         return "Event Full"
       elsif self.available == false 
        return "Closed"
       end
     end

     def return_total
        total = 0
        self.guests.each do |g|
            total += g.total
        end
        return total
     end

    def map_url
   
        parse_address = self.address.split(" ").join("+")

        return  "https://www.google.com/maps/dir/?api=1&destination=#{parse_address}"
    end

    def capitalize_name 
        self.name = self.name.capitalize
    end
end
