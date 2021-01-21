package oop;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/*
 * 2. 150779 Primzahlen
 * 
 * 3. Mein PC hat 2 Cores.
 * 
 * 1 Thread  = 273254 ms
 * 2 Threads = 185359 ms Speedup ~ 1,47
 * 4 Threads = 150779 ms Speedup ~ 1,81
 * 8 Threads = 143734 ms Speedup ~ 1,9
 * 
 * 4. Man könnte die Methode isPrime() weglassen oder grundsätzlich den Mechanismus ändern, da immer von 0-x wiederholt 
 * 	  wird um zu schauen ob n eine Primzahl ist. Bspw. mit dem Sieb des Erasthones.
 * 		
 */
public final class PrimeCounterParallel {
	
	public static int countPrimes(int noThreads, int target) throws ExecutionException, InterruptedException {

		if (target == 0) {
			return 0;
		}else if(target < noThreads) { //if there are less numbers to be tested than Threads no use for parallelism
			return countPerThread(0, target);
		}
		int partialAmount = (int) target/noThreads;
		
		List<Integer> results = new ArrayList<>();
		ExecutorService executorService = Executors.newFixedThreadPool(noThreads);
		List<Future<Integer>> futures = new ArrayList<Future<Integer>>();
		
		//Make each Thread Calculate a predefined Section in the interval 
		int currentThread = 0;
		for(int i = 1; i < target; i+= partialAmount) {
			int start = i;
			currentThread++;
			if(currentThread == noThreads) { //set end of last thread to target because i+partialAmount can be smaller/larger than target
				Callable<Integer> singleCallable = () -> {return countPerThread(start, target);};
				futures.add(executorService.submit(singleCallable));
			}else {
				Callable<Integer> singleCallable = () -> {return countPerThread(start, start+partialAmount);};
				futures.add(executorService.submit(singleCallable));
			}
		}
		
		for(Future<Integer> future : futures) {
			try{
				Integer result = future.get();
				results.add(result);
			}catch(ExecutionException ex) {
				
			}
		}
		
		return getSumList(results);
	}
	
	//counts the amount of Primes over a pre-defined interval
	private static int countPerThread(int start, int end) {
		int tmp = 0;
		for(int i = start; i < end; i++) {
			if(PrimeTester.isPrime(i)) {
				tmp++;
			}
		}
		return tmp;
	}
		
	//calculates the Sum of a List
	private static int getSumList(List<Integer> list) {
		int sum = 0;
		for(Integer d : list)
		    sum += d;
		return sum;
	}
	
	public static void main(String[] args) {

		try {
			final int target = 100000000;
			final long startTime = System.currentTimeMillis();
			int countPar;
			countPar = countPrimes(1, target);
			final long endTime = System.currentTimeMillis();
			System.out.println("Duration for interval [2," + target + "] is "+ (endTime - startTime) + " ms\n" + countPar + " primes");
		} catch (ExecutionException | InterruptedException e) {
			e.printStackTrace();
		}
	}

}
