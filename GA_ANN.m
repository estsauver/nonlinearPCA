% % GA_ANN   Tunes the weighting factors of a simple ANN by using GA
% %
% %          Minimize the sum of square errors for y1 and y2
% %
% %**************************************************************************
% global TrainSet ga_net
% clear
% clc
% load SimData.txt
% [ix,iy]=size(SimData);
% y1=SimData(:,1); y2=SimData(:,2);
% TrainSet=[y1 y2 y1 y2];
% 
% %**************************************************************************
% %Loads preconfigured nerual network created with nntool from saved form.
% %Loads variable neural_network
% load ga_net.mat;
% % ga_net.initFcn = 'initlay';
% % ga_net.trainFcn = 'trainlm';
% % ga_net = init(ga_net);
% % 
% % %**************************************************************************
% % 
% popSize=1000;
% f_bounds=zeros(27,2);
% f_bounds(:,1)=-4; f_bounds(:,2)=4;
% evalFN='w_find';
% 
% initPop=initializega(popSize,f_bounds,evalFN);
% [wbest,endPop,bestPop,traceInfo]=ga(f_bounds,evalFN,[],initPop,[],'maxGenTerm',[1000],...
%                    'normGeomSelect',[0.08],['arithXover'],[2 0],...
%                    'nonUnifMutation',[4 1000 3]);
% plot(bestPop(:,1),bestPop(:,size(bestPop,2)),'--rs','LineWidth',2,...
%                    'MarkerEdgeColor','k',...
%                    'MarkerFaceColor','g',...
%                    'MarkerSize',2);
% %                
% % Train(ga_net,TrainSet(:,1:2)',TrainSet(:,1:2)');
% ga_net.IW{1} = reshape(wbest(1:6),3,2);
%     ga_net.LW{2,1} = wbest(7:9);
%     ga_net.LW{3,2} = reshape(wbest(10:12),3,1);
%     ga_net.LW{4,3} = reshape(wbest(13:18),2,3);
%     ga_net.b{1}=reshape(wbest(19:21),3,1);
%     ga_net.b{2}=wbest(22);
%     ga_net.b{3}=reshape(wbest(23:25),3,1);
%     ga_net.b{4}=reshape(wbest(26:27),2,1);
    xcalc = sim(ga_net,TrainSet(:,1:2)');
    xdata=TrainSet(:,1:2)';
subplot(2,1,1)
hold on;
plot(xcalc(1,:)); plot(xdata(1,:),'-r');
hold off;
subplot(2,1,2)
hold on;
plot(xcalc(2,:)); plot(xdata(2,:),'-r');
hold off;
figure;
hold on;
plot(xdata(1,:),xdata(2,:),'or','MarkerFaceColor','r')
axis([-1 1 -1 1]);
plot(xcalc(1,:),xcalc(2,:),'^b','MarkerFaceColor','b');
hold off;


%Validation Run
% ga_net.IW{1} = reshape(wbest(1:6),3,2);
%     ga_net.LW{2,1} = wbest(7:9);
%     ga_net.LW{3,2} = reshape(wbest(10:12),3,1);
%     ga_net.LW{4,3} = reshape(wbest(13:18),2,3);
% randu = rand(1,1000)*2*pi;
% y1 = 0.8*sin(randu); y2= 0.8*cos(randu); 
% validationData= [ y1; y2]';
% validationTest = sim(ga_net, validationData')';
% figure
% hold on;
% plot(validationData(:,1),validationData(:,2),'or','MarkerFaceColor','r')
% axis([-1 1 -1 1]);
% plot(validationTest(:,1),validationTest(:,2),'^b','MarkerFaceColor','b');
% hold off;



    

               





