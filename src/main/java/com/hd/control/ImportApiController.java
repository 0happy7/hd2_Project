package com.hd.control;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class ImportApiController {

    private IamportClient api;

    public ImportApiController() {
        // REST API 키와 REST API secret 를 아래처럼 순서대로 입력한다.
        this.api = new IamportClient("1756661250024508","aJr3wZ6vYtPRmg82SoL0ugbxRVUdZ14NIYfO6YhLXO7xhLo5OptX2aI3Av9o87bKWI4CBTwhLdRZ7OYb");
    }
    
    
    @RequestMapping(value="/verifyIamport/{imp_uid}")
    @ResponseBody
    public IamportResponse<Payment> paymentByImpUid(
            Model model
            , Locale locale
            , HttpSession session
            , @PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException
    {	
    	System.out.println("검증");
        return api.paymentByImpUid(imp_uid);
    }
    
    
}

