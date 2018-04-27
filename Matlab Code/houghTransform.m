function [rho,theta,houghSpace] = houghTransform(theImage,thetaSampleFrequency)

    %Definisco lo spazio hough
    theImage = flipud(theImage);
    [width,height] = size(theImage);

    rhoLimit = norm([width height]);
    rho = (-rhoLimit:1:rhoLimit);          
    theta = (0:thetaSampleFrequency:pi);

    numThetas = numel(theta);
    houghSpace = zeros(numel(rho),numThetas);

    %trovo i pixel classificati come edge
    [xIndicies,yIndicies] = find(theImage);

    %Alloco spazio per l'array accumulator
    numEdgePixels = numel(xIndicies);
    accumulator = zeros(numEdgePixels,numThetas);

    %Per aumentare la velocità, alloco spazio per il sine e cosine.
    cosine = (0:width-1)'*cos(theta); 
    sine = (0:height-1)'*sin(theta); 

    accumulator((1:numEdgePixels),:) = cosine(xIndicies,:) + sine(yIndicies,:);

    %Ciclo sui theta e ottengo i valori rho 
    for i = (1:numThetas)
        houghSpace(:,i) = hist(accumulator(:,i),rho);
    end
    pcolor(theta,rho,houghSpace);
    shading flat;
    xlabel('Theta (radians)');
    ylabel('Rho (pixels)');
    colormap('gray');

end