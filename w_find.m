function [sol, result] = w_find(sol, options)
    global TrainSet ga_net
    ga_net.IW{1} = reshape(sol(1:6),3,2);
    ga_net.LW{2,1} = sol(7:9);
    ga_net.LW{3,2} = reshape(sol(10:12),3,1);
    ga_net.LW{4,3} = reshape(sol(13:18),2,3);
    ga_net.b{1}=reshape(sol(19:21),3,1);
    ga_net.b{2}=sol(22);
    ga_net.b{3}=reshape(sol(23:25),3,1);
    ga_net.b{4}=reshape(sol(26:27),2,1);
    %For inserting validation into evaluation function
    if rand()<0
        randu = rand(1,100)*2*pi;
        y1 = 0.8*sin(randu); y2= 0.8*cos(randu); 
        validationData= [ y1; y2]';
        validationTest = sim(ga_net, validationData')';
        diffs=validationTest - validationData;
        diffSum=sum(sum(diffs.^2));
        diffAvg = diffSum/numel(diffs);
        result = 1/diffAvg;
        return
    end
    output = sim(ga_net, TrainSet(:,1:2)');
    diffs=output - TrainSet(:,1:2)';
    diffSum=sum(sum(diffs.^2));
    diffAvg = diffSum;
    result = 1/diffAvg;
end