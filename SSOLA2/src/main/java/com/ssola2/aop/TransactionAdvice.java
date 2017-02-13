package com.ssola2.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Aspect
@Component("transactionAdvice")
public class TransactionAdvice {

	@Autowired
	@Qualifier("txManager")
	private PlatformTransactionManager txManager;
	
	@Around(value = "execution(* com.ssola.model.service.*Service.*Tx(..))")
	public Object doInTransaction(ProceedingJoinPoint joinPoint) {
		TransactionStatus txStatus = txManager.getTransaction(new DefaultTransactionDefinition());
		Object returnValue = null;
		System.out.println("in trans");
		try {
			returnValue = joinPoint.proceed();
			txManager.commit(txStatus);
		} catch (Throwable e) {
			e.printStackTrace();
			txManager.rollback(txStatus);
		}
		System.out.println("out trans");
		return returnValue;
	}
	
}
