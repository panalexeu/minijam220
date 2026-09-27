function split(str, sep)
  local parts = {}
  for part in string.gmatch(str, "([^" .. sep .. "]+)") do
    table.insert(parts, part)
  end
  return parts
end

function vec_m_scalar(vec, scalar)
  local t = {}
  for i=1,#vec do 
    t[i] = vec[i] * scalar
  end 
  return t 
end 

function vec_d_scalar(vec, scalar)
  if scalar == 0 then return vec end

  local t = {}
  for i=1,#vec do 
    t[i] = vec[i] / scalar
  end
  return t
end 

function vec_cat(vec1, vec2)
  local out = {}
  for i=1,#vec1 do out[#out+1] = vec1[i] end  
  for i=1,#vec2 do out[#out+1] = vec2[i] end  
  return out 
end  

function vec_arrange(l, r)
  if l > r then 
    return nil
  end 
  
  local out = {}
  for i=l,r do out[i-l+1] = i end
  return out
end

function vec_state_arrange(num)
  if num < 1 then 
    return nil
  end 
  
  local out = {}
  for i=1,num do out[i] = false end
  return out
end 

function str_vec(vec)
  io.write('vec size ('.. #vec .. '): ')
  for i=1,#vec do io.write(tostring(vec[i]), ' ') end
  print('')
end 

function vec_len(vec)
  s = 0 
  for i=1,#vec do 
    s = s + (vec[i] * vec[i])
  end 
  s = math.sqrt(s)
  return s 
end 

function contains(item, vec) 
  for i=1,#vec do  
    if vec[i] == item then return i end 
  end
  return -1 
end 