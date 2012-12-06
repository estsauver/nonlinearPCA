%**********************************************************************
%  Generate Data Set
%     y1 = 0.8*sin(theta)
%     y2 = 0.8*cos(theta)
%**********************************************************************
y=zeros(100,2);
for i=1:100
    theta=2*pi*rand;        % random uniform distribution 
    y(i,1)=0.8*sin(theta);
    y(i,2)=0.8*cos(theta);
end
hold on;
plot(y(:,1),y(:,2),'or','MarkerFaceColor','r')
axis([-1 1 -1 1]);
%**********************************************************************
%  pcares : residuals from PCA
%           recon_y is the reconstructed data set from 1 PC
%**********************************************************************
[resid,recon_y] =pcares(y,1);
[pc,score,latent]=princomp(zscore(y));
plot(recon_y(:,1),recon_y(:,2),'^b','MarkerFaceColor','b');
hold off;
fprintf('Norm of Residual Error: %g\n',norm(resid))
fprintf('Normalized Eigenvalues: %6.2f \n                        %6.2f\n\n',latent);
%**********************************************************************
%  ANN Model
%**********************************************************************
figure;
y_in=y'; y_t=y';
net=newff(y_in,y_t,[8 1 8],{'tansig' 'tansig' 'tansig' 'purelin'},'traingdm');
net.trainParam.epochs = 30000;
net.trainParam.max_fail = 50;
[net,tr,yy,e]=train(net,y_in,y_t);
y_out=sim(net,y_in);
hold on;
plot(y(:,1),y(:,2),'or','MarkerFaceColor','r')
axis([-1 1 -1 1]);
plot(y_out(1,:),y_out(2,:),'^b','MarkerFaceColor','b');
hold off;
fprintf('Norm of Network Error: %g\n',norm(e));



