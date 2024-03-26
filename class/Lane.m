classdef Lane < handle
    properties
        start_position=0;
        length=0;
        width=0;
    end

    methods
        function obj=Lane(start_position,length,width)
            obj.start_position=start_position;
            obj.length=length;
            obj.width=width;
        end
    end
end