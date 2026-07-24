Class {
	#name : 'CTVMProfilerRunner',
	#superclass : 'Object',
	#instVars : [
		'benchmarkClass',
		'executionTime',
		'allocatedBytes',
		'gcTime'
	],
	#category : 'Containers-Treap-Benchmarks',
	#package : 'Containers-Treap-Benchmarks'
}

{ #category : 'accessing' }
CTVMProfilerRunner >> benchmarkClass: aClass [
	benchmarkClass := aClass
]

{ #category : 'export' }
CTVMProfilerRunner >> exportToJson [
	^ '{ "benchmark": "', benchmarkClass name asString, 
	  '", "executionTimeMs": ', executionTime asMilliSeconds asString, 
	  ', "gcTimeMs": ', gcTime asString, 
	  ', "allocatedBytes": ', allocatedBytes asString, ' }'
]

{ #category : 'running' }
CTVMProfilerRunner >> run [
	| instance time beforeGC afterGC |
	instance := benchmarkClass new.
	instance setUp.
	
	Smalltalk garbageCollect.
	beforeGC := Smalltalk vm totalGCTime.
	
	time := [ instance run ] timeToRun.
	
	afterGC := Smalltalk vm totalGCTime.
	executionTime := time.
	gcTime := afterGC - beforeGC.
	allocatedBytes := 0
]
