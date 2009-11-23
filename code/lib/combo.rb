
#Got it from http://frottage.org/rjp/ruby/
class Array
	def combinations(n)
		n=self.size if n > self.size
		
		return if n==0

		if n == self.size then
			if block_given? then 
				yield self 
				return
			else 
				return [self]
			end
		end	
	
		if n == 1 then
			if block_given? then
				self.each { |i| yield [i] }
				return
			else
				d=[]
				self.each { |i| d.push([i]) }	
				return d
			end	
		end

		d=[]
		self.each_index { |i|
			b=self.dup
			c=b.delete_at(i)
			b.combinations(n-1) {|x|
				m=[c, x].flatten.sort
				d.push(m)
			}
		}
		if block_given? then
			d.uniq.each {|i| yield i }
		else
			return d.uniq
		end
	end
end
