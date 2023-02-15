package com.fp.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class sessionCheck
{
	// Admin 관리자
	
	// 세션값을 가져와서 null값이면 로그인폼 페이지로 전환
	public void getSession(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		if(session.getAttribute("adminSession")==null)
		{
			try
			{
				response.sendRedirect("adminloginform.action");
				
			} catch (IOException e)
			{
				System.out.println(e.toString());
			}
		}
		
	}

	// 세션 값을 가져와서 null 값인 경우 - 로그인폼 페이지로 전환
	// null 값이 아닌 경우 adminSession 이름으로 저장된 관리자 세션값(admin_num)을 반환
	public String getAttribute(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		String result = "";
		
		if(session.getAttribute("adminSession")==null)
		{
			try
			{
				response.sendRedirect("adminloginform.action");
				
			}  catch (IOException e)
			{
				System.out.println(e.toString());
			}
		}
		else
		{
			String session_value = (String)session.getAttribute("adminSession");
			result = session_value;
		}
		
		return result;
	}
	
	// User 사용자
	// 세션값을 가져와서 null값이면 로그인폼 페이지로 전환
	
	public void getUserSession(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userSession")==null)
		{
			try
			{
				response.sendRedirect("userloginform.action");
				
			} catch (IOException e)
			{
				System.out.println(e.toString());
			}
		}
		
	}
	
	// 세션 값을 가져와서 null 값인 경우 - 로그인폼 페이지로 전환
	// null 값이 아닌 경우 userSession 이름으로 저장된 유저 세션값(sign_num)을 반환
	public String getUserAttribute(HttpServletRequest request, HttpServletResponse response)
	{
		HttpSession session = request.getSession();
		String result = "";
		
		if(session.getAttribute("userSession")==null)
		{
			try
			{
				response.sendRedirect("userloginform.action");
				
			}  catch (IOException e)
			{
				System.out.println(e.toString());
			}
		}
		else
		{
			String session_value = (String)session.getAttribute("userSession");
			result = session_value;
		}
		
		return result;
	}
}
