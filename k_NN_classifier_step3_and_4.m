clear

%% Algo

%Step-1: Select the number K of the neighbors. 

%Step-2: Calculate the Euclidean distance of all neighbors. 

%Step-3: Take the K nearest neighbors as per the calculated Euclidean distance. 

numPointsToClassify = 3;
K = 5; 


%fyll data med label i førse rad og distanse i andre rad
matrixRow1 = {'1' '2' '3' '1' '2' '1' '3' ;1 3 3 1 3 1 3}; % '1' = 1, '2' = 3, '3' = 3
matrixRow2 = {'1' '2' '3' '1' '2' '1' '3' ;4 1 3 4 1 4 3}; % '1' = 4, '2' = 1, '3' = 3
matrixRow3 = {'1' '2' '3' '1' '2' '1' '3' ;4 3 1 4 3 4 1}; % '1' = 4, '2' = 3, '3' = 1

distanceMatrixWithLabel = [matrixRow1;matrixRow2;matrixRow3];

%sorterer distanse matrisen
for i = 1:2:numPointsToClassify*2
    matrixRowI = distanceMatrixWithLabel(i:i+1,:);
    distanceMatrixSorted(i:i+1,:) = sortrows(matrixRowI',2)';
end

%Step-4: Among these k neighbors, count the number of the data points in each category.
predictedLabels = zeros(numPointsToClassify,1); %vector som skal gi resultatet til hva de ulike punktene klassifiseres som

KClosest = distanceMatrixSorted(:,1:K);
for i = 0:numPointsToClassify-1
    diffLabels = cell2mat(unique(distanceMatrixSorted(2*i+1,:))); %liste med de ulike klassene funnet blant de K nærmeste
    maxCount = 0;
    maxLabel = 0;
    for j = 1:length(diffLabels)
        M = cell2mat(KClosest(2*i+1,:));
        L = length(find(M == diffLabels(j)));
        if L>maxCount
            maxLabel = diffLabels(j);
            maxCount=L;
        end
    end
    predictedLabels(i+1) = str2double(maxLabel);
end

%totalMatrix
%distanceMatrixSorted(:,4) = [];
%distanceMatrixSorted
predictedLabels
%KClosest
