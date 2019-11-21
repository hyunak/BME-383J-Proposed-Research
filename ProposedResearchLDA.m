function [AUC] = LDA1(data) % declare function
    % Feature extraction - texture
    texture = data(:,1);
    % make matrices with each of data set
    texturedata = [truth,texture];
    % Sort rows in ascending order
    textureSort = sortrows(texturedata,2);
    s = size(data); % get size of the matrix
    row = s(1,1);
    % create empty matrices for storing sensitivity and 1-specificity values
    matrix1 = zeros(row,2); 
   
    % texture
    for i = 1:row % outer for loop
        decisiondataCopy = textureSort; % make a copy to alter values
        threshold = textureSort(i,2); % assign threshold
        for j = 1:row % inner for loop
            if textureSort(j,2)<=threshold
                decisiondataCopy(j,2)=0; % if decision variable <= threshold, predicted value = 0
            else
                decisiondataCopy(j,2)=1; % if decision variable > threshold, predicted value = 1
            end
        end
        [sens,spec] = ROCpoint(decisiondataCopy); % call ROCpoint
        matrix(i,:)=[sens,1-spec]; % Store values into matrix
    end
    
    % plot for Mean Texture ROC
    first=[1,1];
    final=[first;matrix]; % first point = [1,1]
    x=final(:,2); % separate x and y values
    y=final(:,1);
    subplot(3,2,2)
    plot(x,y,'-o'); % plot 1-specificity vs sensitivity
    title('Mean Texture ROC')
    xlabel('1-Specificity');
    ylabel('Sensitivity');
    %[AUC]=-trapz(x,y);
  
    % calculate area under the curve using the trapezoid rule
    % Mean Texture
    s = size(final);
    row = s(1,1);
    area= 0;
    for i = 1:row-1
        area = area+(0.5)*(x(i)-x(i+1))*(y(i)+y(i+1)); % trapezoid rule
    end
    [AUC2]=area;
    roundedAUC2 = sprintf('%.2f', AUC2);
    fprintf('Mean Texture AUC = %.2f\n',AUC2); % print AUC
   
    % print AUC in Mean Area ROC
    figure();
    string = num2str(roundedAUC2);
    text(0.3,0.2,'AUC =');
    text(0.6,0.2,string);
end