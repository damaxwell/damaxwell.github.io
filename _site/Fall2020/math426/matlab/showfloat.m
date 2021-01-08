%
% [s,E,m] = showfloat(x)
%
% Input:
% x: a double precision floating point number
%
% Output
% s: a string representation of the sign bit 0/1
% E: a string representation of the exponent bits (11 bits)
% m: a string representation of the mantissa bits (52 bits)
%
% Example:
%
% [s,E,m] = showfloat(0.1)
% s = 0
% E = 01111111011
% m = 1001100110011001100110011001100110011001100110011010

function [s,E,m] = showfloat(x)

	hexbits = num2hex(x);


	table = [ 
		"0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111","1000", "1001", "1010", "1011","1100", "1101", "1110", "1111"
		];

	charbits = "";

	for k=char(hexbits)
		charbits = sprintf("%s%s",charbits,table(hex2dec(k)+1));
	end

	bp = [];
	for b=char(charbits)
		if b=="0"
			bp = [bp 0];
		else
			bp = [bp 1];
		end
	end

	s = sprintf("%d", bp(1) );%
	E = sprintf("%d%d%d%d%d%d%d%d%d%d%d",bp(2:12));
	m = sprintf("%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",bp(13:64));
end
