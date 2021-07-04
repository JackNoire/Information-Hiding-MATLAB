function norm = imshow_norm(img)
    norm = (img - min(img(:)))/(max(img(:))-min(img(:)));
    imshow(norm);
end

