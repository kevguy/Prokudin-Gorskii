function output = alignMultiCurSsd(img,B)

    imgSize = size(img, 1);
    if (imgSize > 128)
        Cur1 = imresize(B, 0.5);
        Cur2 = imresize(img, 0.5);
        
        range = alignMultiCurSsd(Cur1, Cur2);
        
        minMetric = inf;
        
        for x = -15 + range(2)*2:15 + range(2)*2
            for y = -15 + range(1)*2:15 + range(1)*2
                tmp = circshift(img, [x y]);
                ssd = sum(sum((B-tmp).^2));
                if ssd < minMetric
                    minMetric = ssd;
                    output = [x y];
                end
            end
        end 
    else
        minMetric = inf;
        for x = -15:15
            for y = -15:15
                tmp = circshift(img, [x y]);
                ssd = sum(sum((B-tmp).^2));
                if ssd < minMetric
                    minMetric = ssd;
                    output = [x y];
                end
            end
        end 
    end
    
end

