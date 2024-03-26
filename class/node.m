classdef Node < handle

    properties
        nodeID=1;
        position=0;
        radius=200; % coverage, m
        content; % caching space
    end

    methods
        function obj=Node(ID,position,radius,contentSize)
            obj.nodeID=ID;
            obj.position=position;
            obj.radius=radius;
            obj.content=cell(contentSize,1);
        end

        function obj=updateContent(obj,content)
            % update storage with content
            if length(obj.content)<length(content)
                disp('Cannot update content due to storage overflow.');
            else
                obj.content=content;
            end
        end

        function sendSignal(obj,signal)
            communicationNetwork=getCommunicationNetwork();
            communicationNetwork.send(obj,signal);
        end

        function [message,sender]=receiveSignal(obj)
            message=communicationNetwork.receive(obj);
            sender=message.sender;
        end
    end
end