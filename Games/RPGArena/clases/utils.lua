
local _utils = {}

function _utils.cleanGroup(group)
  
  for i=group.numChildren,1,-1 do
	if group[i].timers then
				for j = 1,#group[i].timers do
							         	
							timer.cancel(group[i].timers[j])
			    end
			
			end
			if group[i].transitions then
				for j = 1,#group[i].transitions do
							         	
							transition.cancel(group[i].transitions[j])
			    end
			
			end
	      group[i]:removeSelf()
	 end

end

function _utils.cleanObject(item)
  

	if item.timers then
	    for j = 1,#item.timers do
							         	
			timer.cancel(item.timers[j])
	    end
			
	end
	
	if item.transitions then
		for j = 1,#item.transitions do		         	
			transition.cancel(item.transitions[j])
	    end
			
	end
	

end

return _utils