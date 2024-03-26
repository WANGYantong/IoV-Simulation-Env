classdef Road < handle

    properties
        length=1e3; % length of road
        num_lanes=4;
        lane_width=4;
        lanes={}; 
    end

    methods
        function obj=Road(length,num_lanes,lane_width)
            obj.length=length;
            obj.num_lanes=num_lanes;
            obj.lane_width=lane_width;
            obj.lanes=obj.createLanes();
        end

        function lanes=createLanes(obj)
            lanes=cell(obj.num_lanes,1);
            for ii=1:obj.num_lanes
                start_position=(ii-1)*obj.lane_width;
                lanes{ii}=Lane(start_position,obj.length,obj.lane_width);
            end
        end

        function lane=getLaneAtPosition(obj,position)
            lane_index=floor(position/obj.lane_width)+1;
            lane=obj.lanes{lane_index};
        end
    end
        
end


