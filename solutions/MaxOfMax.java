package oop;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class MaxofMax {
	
	public int calculateMax(Collection<List<Integer>> blocksOfNumbers,
                            int numberThreads) throws ExecutionException, InterruptedException {
		
        if (blocksOfNumbers.size() == 0) {
            return Integer.MIN_VALUE;
        }
        
        List<Integer> results = new ArrayList<>();
        ExecutorService executorService = Executors.newFixedThreadPool(numberThreads);
        List<Future<Integer>> futures = new ArrayList<Future<Integer>>();
        
        for(List<Integer> list : blocksOfNumbers) {
        	Callable<Integer> singleCallable= () -> {return findMax(list);};
        	futures.add(executorService.submit(singleCallable));
        }
        
        for(Future<Integer> future : futures) {
        	try{
        		Integer result = future.get();
        		results.add(result);
        		}catch(ExecutionException ex) {
        	}
        }
        
        return findMax(results);
    }

    private Integer findMax(Collection<Integer> numbers) {
        Integer maxValue = Integer.MIN_VALUE;
        for (Integer number : numbers) {
            if (number > maxValue) {
                maxValue = number;
            }
        }
        return maxValue;
    }

    private Integer findMaxStream(Collection<Integer> numbers){
        return 0;
    }
}
