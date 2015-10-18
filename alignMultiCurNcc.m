function output = alignMultiCurNcc(img,B)
    disp('loop');
    imgSize = size(img, 1);
    if (imgSize > 128)
        Cur1 = imresize(B, 0.5);
        Cur2 = imresize(img, 0.5);
        
        range = alignMultiCurNcc(Cur1, Cur2);
        disp('im out');
        
        maxMetric = -inf;
        
        for x = -15 + range(2)*2:15 + range(2)*2
            for y = -15 + range(1)*2:15 + range(1)*2
                tmp = circshift(img, [x y]);
                ncc = (dot(B(:),tmp(:)))/norm(B(:))/norm(tmp(:));
                if ncc > maxMetric
                    maxMetric = ncc;
                    output = [x y];
                end
            end
        end 
    else
        disp('real work');
        maxMetric = -inf;
        for x = -15:15
            for y = -15:15
                tmp = circshift(img, [x y]);
                ncc = (dot(B(:),tmp(:)))/norm(B(:))/norm(tmp(:));
                if ncc > maxMetric
                    maxMetric = ncc;
                    output = [x y];
                end
            end
        end 
        disp(output);
    end
    
end

