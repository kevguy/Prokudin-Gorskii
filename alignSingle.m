function aimg = alignSingle(img,B)
% This function is to align img to B using single-scale algorithms
% Output is the aligned version of img
	[h,w] = size(B);
	% TODO: Write your codes for single-scale implementation
	% Initialize variables
	minMetric = inf; % minimum metric value
    maxMetric = -inf;
	
	% TODO2: Matching in single-scale
    choice = 'ncc';
    
    switch(choice)
        case 'ssd'
        disp(choice)
        % Sum of squared differences (SSD): sum((image1-image2).^2 )
        for x = -15:15
            %disp(x)
            for y = -15:15
                %disp(y)
                tmp = circshift(img, [x y]);
                ssd = sum(sum((B-tmp).^2));
                %disp(ssd)
                if ssd < minMetric
                    minMetric = ssd;
                    output = [x y];
                end
            end
        end
        disp('inside ssd');
        disp(output);
        % Output aimg
        aimg = circshift(img, output);
        
        case 'ncc'
        disp(choice)
        % Normalized cross correlation: dot(image1./||image1||, image2./||image2|| )
        for x = -15:15
            for y = -15:15
                tmp = circshift(img, [x y]);
                ncc = (dot(B(:),tmp(:)))/norm(B(:))/norm(tmp(:));
                %disp(ncc)
                if ncc > maxMetric 
                    maxMetric = ncc;
                    output = [x y];
                end
            end
        end
        disp('inside ncc');
        disp(output);
        % Output aimg
        aimg = circshift(img, output);
    end
    disp('output');
    disp(output);
end


