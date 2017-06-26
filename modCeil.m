function [ number ] = modCeil( number )

if ceil(number)==number
    number=number+1;
else
    number=ceil(number);
end


end

