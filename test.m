clc;
clear;
addpath(genpath(pwd));

%% test class vehicle
% ID allocation, vehicle:1-1000; RSU:1001-1100; MBS:1110-1120
car1=vehicle(1,200,10,1,5,'East'); % position,speed,lane,length,direction
car2=vehicle(2,200,15,3,5,'West');
car3=vehicle(3,200,10,2,5,'East');
commNetwork=CommunicationNetwork({car1,car2});
commNetwork=commNetwork.addVehicle(car3);

delta_time=1;
for ii=1:10
    car1.updatePosition(delta_time);
    car2.updatePosition(delta_time);
    disp(['Time ' num2str(ii) 's: Car1 position = ' num2str(car1.position)...
        ' meters, speed = ' num2str(car1.speed) ' m/s']);
    disp(['Time ' num2str(ii) 's: Car2 position = ' num2str(car2.position)...
        ' meters, speed = ' num2str(car2.speed) ' m/s']);
    car1.accelerate(1);
    car2.brake(1);
end

message='Hello';
commNetwork.broadcastMessage(message);
commNetwork.sendMessage(car2.vehicleID, car3.vehicleID, message);

commNetwork=commNetwork.removeVehicle(car2);
status=commNetwork.sendMessage(car1.vehicleID, car2.vehicleID, message);