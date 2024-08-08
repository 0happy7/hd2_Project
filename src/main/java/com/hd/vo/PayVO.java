package com.hd.vo;

public class PayVO {
	private int payno;  			//결제번호
	private int porderno; 			//주문번호
	private int puserno;			//회원번호
	private String payment; 		//결제수단
	private String paydate; 		//결제일시
	private int payprice;  			//결제금액
	private String cardcom; 		//카드사
	private int installment; 		//할부개월
	private String bank;			//입금자은행
	private String depositor;		//입금자명
	
	public int getPayno() 			{	return payno;		}
	public int getPorderno()		{	return porderno;	}
	public String getPayment() 		{	return payment;		}
	public String getPaydate() 		{	return paydate;		}
	public int getPayprice() 		{	return payprice;	}
	public String getCardcom() 		{	return cardcom;		}
	public int getInstallment() 	{	return installment;	}
	public String getBank() 		{	return bank;		}
	public String getDepositor() 	{	return depositor;	}
	public int getPuserno() 		{	return puserno;		}
	
	public void setPayno(int payno) 			{	this.payno = payno;				}
	public void setPorderno(int porderno) 		{	this.porderno = porderno;		}
	public void setPayment(String payment) 		{	this.payment = payment;			}
	public void setPaydate(String paydate) 		{	this.paydate = paydate;			}
	public void setPayprice(int payprice) 		{	this.payprice = payprice;		}
	public void setCardcom(String cardcom) 		{	this.cardcom = cardcom;			}
	public void setInstallment(int installment) {	this.installment = installment;	}
	public void setBank(String bank) 			{	this.bank = bank;				}
	public void setDepositor(String depositor) 	{	this.depositor = depositor;		}
	public void setPuserno(int puserno) 		{	this.puserno = puserno;			}
	
	public void printinfo() {
		System.out.println("결제정보 VO");
		System.out.println(payno);
		System.out.println(porderno);
		System.out.println(puserno);
		System.out.println(payment);
		System.out.println(paydate);
		System.out.println(payprice);
		System.out.println(cardcom);
		System.out.println(installment);
		System.out.println(bank);
		System.out.println(depositor);
		System.out.println("-------------------------------");
	}
	
	
	
}
