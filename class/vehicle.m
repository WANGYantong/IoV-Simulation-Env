classdef vehicle < handle
    %VEHICLE simulate the vechile in IoV

    properties
        vehicleID=1;
        position=0;
        speed=0;
        lane=1; % the lane vehicle running on, start from 1
        length=5; % the length of vehicle, the value varies according to the type
        direction='East'; % 'East' or 'West'
        type='vehicle';
    end

    methods
        function obj=vehicle(vehicleId,position,speed,lane,length,direction)
            obj.vehicleID=vehicleId;
            obj.position=position;
            obj.speed=speed;
            obj.lane=lane;
            obj.length=length;
            obj.direction=direction;
        end

        function obj=updatePosition(obj,delta_time)
            if strcmp(obj.direction,'East')
                obj.position=obj.position+obj.speed*delta_time;
            else
                obj.position=obj.position-obj.speed*delta_time;
            end
        end

        function obj=accelerate(obj,acceleration)
            obj.speed=min(obj.speed+acceleration,30); % max speed is 30m/s
        end

        function obj=brake(obj,deceleration)
            obj.speed=max(obj.speed-deceleration,0); % min speed is 0m/s
        end

        function obj=changeLane(obj,new_lane)
            obj.lane=new_lane;
        end

        function obj = receiveMessage(obj, message)
            disp(['ID ' num2str(obj.vehicleID) ' Received message: ' message]);
        end
  
    end
end

