function isEdge = is_edge(block, x, y)
%isEdge �ж�block�е�x��y�Ƿ�Ϊ�߽�
    [sizeX, sizeY] = size(block);
    for i = -1:1
        for j = -1:1
            if x+i >= 1 && x+i <= sizeX && y+j >= 1 && y+j <= sizeY
                if block(x+i, y+j) ~= block(x, y)
                    isEdge = true;
                    return;
                end
            end
        end
    end
    isEdge = false;
end

