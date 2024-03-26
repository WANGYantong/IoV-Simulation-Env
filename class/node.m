classdef node < handle

    properties
        position=0;
        radius=200; % coverage, m
        content=[];
    end

    methods
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