classdef CommunicationNetwork < handle
    properties (Access=private)
        % vehicleID=[];
        % RSUID=[];
        % MBSID=[];
        % connection;
    end
    properties (Access=public)
        vehicles={};
        vehicleID=[];
        % RSU={};
        % RSUID=[];
        % MBS={};
        % MBSID=[];
        % connection;
    end

    methods (Access=public)
        % function obj=CommunicationNetwork(vehicles,RSU,MBS,edge)
        function obj=CommunicationNetwork(vehicles)
            obj.vehicles=vehicles;
            if ~isempty(vehicles)
                N=length(vehicles);
                for ii=1:N
                    obj.vehicleID(end+1)=vehicles{ii}.vehicleID;
                end
            end
            % obj.RSU=RSU;
            % obj.MBS=MBS;
            % obj.connection=edge;
        end

        function obj=addVehicle(obj,vehicle)
            vehicleIndex=find(obj.vehicleID==vehicle.vehicleID,1);
            if isempty(vehicleIndex)
                obj.vehicles{end+1}=vehicle;
                obj.vehicleID(end+1)=vehicle.vehicleID;
                disp(['Add vehicle with ID ' num2str(vehicle.vehicleID)...
                    ' to the network.']);
            else
                disp(['Vehicle with ID ' num2str(vehicle.vehicleID)...
                    ' already in the network.']);
            end
        end

        function obj=removeVehicle(obj,vehicle)
            vehicleIndex=find(obj.vehicleID==vehicle.vehicleID,1);
            if isempty(vehicleIndex)
                disp(['Vehicle with ID ' num2str(vehicle.vehicleID)...
                    ' not found in the network.']);
            else
                obj.vehicles(vehicleIndex)=[];
                obj.vehicleID(vehicleIndex)=[];
                disp(['Remove vehicle with ID ' num2str(vehicle.vehicleID)...
                    ' from the network.']);
            end
        end

        function status=sendMessage(obj, senderId, receiverId, message)
            if ~isempty(obj.vehicles) && any(find(obj.vehicleID==senderId,1))...
                    && any(find(obj.vehicleID==receiverId,1))
                status=true;
                disp('Message sent successfully.');
                obj.vehicles{receiverId}.receiveMessage(message);
            else
                status=false;
                disp('Failed to send message: Sender or receiver not found.');
            end
        end

        function obj = broadcastMessage(obj, message)
            for i = 1:length(obj.vehicles)
                obj.vehicles{i}.receiveMessage(message);
            end
        end
    end
end