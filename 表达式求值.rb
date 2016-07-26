#测试一下Ruby
require 'matrix'
require 'set'
op = Set.new(['+','-','*','/','(',')','#'])
$op_hash = {'+'=>0,'-'=>1,'*'=>2,'/'=>3,'('=>4,')'=>5,'#'=>6}
$op_compare=Matrix[[1,1,-1,-1,-1,1,1],[1,1,-1,-1,-1,1,1],
[1,1,1,1,-1,1,1],[1,1,1,1,-1,1,-1],[-1,-1,-1,-1,-1,0,-2],
[1,1,1,1,-2,1,1],[-1,-1,-1,-1,-1,-2,0]]


$sOPND = []
$sOPTR = ['#']

Caculator = Object.new
def Caculator.EvaluateExpression(input,op)
	i=0
	c=input[i]
	
	while c!='#' or $sOPTR[-1]!='#'
		if not op.include?(c)
		    $sOPND.push(Integer(c))
		    if c!='#'
		    	i+=1
		    	c=input[i]
		    end
		else
		
			if $op_compare[$op_hash[$sOPTR[-1]],$op_hash[c]]==-1
				$sOPTR.push(c)
				if c!='#'
					i+=1
					c=input[i]
				end
			elsif $op_compare[$op_hash[$sOPTR[-1]],$op_hash[c]]==0
				$sOPTR.pop()
				i+=1 
				c=input[i]
			elsif $op_compare[$op_hash[$sOPTR[-1]],$op_hash[c]]==1
				theta = $sOPTR[-1]
				$sOPTR.pop()
				b = $sOPND[-1]
				$sOPND.pop()
				a = $sOPND[-1]
				$sOPND.pop()
				
				if theta == '+'
					$sOPND.push(a+b)
				elsif theta == '-'
					$sOPND.push(a-b)
				elsif theta == '*'
					$sOPND.push(a*b)
				else
					$sOPND.push(Integer(a/b))
				end
				
			end
		end
	end
	$sOPND[-1]
end



print  Caculator.EvaluateExpression("9*1+6/7-2#",op)
