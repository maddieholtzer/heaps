class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
  end

  def count
    @store.length
  end

  def extract
    ret = peek
    @store[0] = @store.pop()
    idx = 0
    child_indices = BinaryMinHeap.child_indices(count,idx)
    while ((child_indices.length>0 && @store[idx] > @store[child_indices[0]]) || (child_indices.length>1 && @store[idx] > @store[child_indices[1]]))
      smallest_child = [@store[child_indices[0]], child_indices[0]]
      smallest_child = [@store[child_indices[1]], child_indices[1]] if child_indices.length>1 && @store[child_indices[1]] < @store[child_indices[0]]
      @store[smallest_child[1]], @store[idx] = @store[idx], smallest_child[0]
      idx = smallest_child[1]
      child_indices = BinaryMinHeap.child_indices(count,idx)
    end
    ret
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    idx = count-1
    while idx>0 && @store[BinaryMinHeap.parent_index(idx)] > val
      @store[BinaryMinHeap.parent_index(idx)], @store[idx] = @store[idx], @store[BinaryMinHeap.parent_index(idx)]
      idx = BinaryMinHeap.parent_index(idx)
    end
  end

  public
  def self.child_indices(len, parent_index)
    start = parent_index*2 + 1
    return [] if start>=len
    return [start] if start==len-1
    [start, start+1]
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    array.each_index do |idx|
      inneridx = idx
      child_indices = BinaryMinHeap.child_indices(len,inneridx)
      if prc
        while ((child_indices.length>0 && prc.call(array[inneridx], array[child_indices[0]])<=0) || (child_indices.length>1 && prc.call(array[inneridx], array[child_indices[1]])<=0))
          smallest_child = [array[child_indices[0]], child_indices[0]]
          smallest_child = [array[child_indices[1]], child_indices[1]] if child_indices.length>1 && prc.call(array[child_indices[1]], array[child_indices[0]])<=0
          array[smallest_child[1]], array[inneridx] = array[inneridx], smallest_child[0]
          inneridx = smallest_child[1]
          child_indices = BinaryMinHeap.child_indices(len,inneridx)
        end
      else
        while ((child_indices.length>0 && (array[inneridx]) > (array[child_indices[0]])) || (child_indices.length>1 && (array[inneridx]) > (array[child_indices[1]])))
          smallest_child = [array[child_indices[0]], child_indices[0]]
          smallest_child = [array[child_indices[1]], child_indices[1]] if child_indices.length>1 && (array[child_indices[1]]) < (array[child_indices[0]])
          array[smallest_child[1]], array[inneridx] = array[inneridx], smallest_child[0]
          inneridx = smallest_child[1]
          child_indices = BinaryMinHeap.child_indices(len,inneridx)
        end
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
  end
end
