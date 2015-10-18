function aimg = alignMulti(img,B)
    choice = 'ncc';
    
    switch(choice)
        case 'ssd'
            output = alignMultiCurSsd(img,B);
            aimg = circshift(img, output);
        case 'ncc'
            output = alignMultiCurNcc(img,B);
            aimg = circshift(img, output);
    end
    disp('im out, output');
    disp(output);
end


