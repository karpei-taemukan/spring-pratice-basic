package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.spring_memberBoard.dao.BoardDao;

public class ChatHandler extends TextWebSocketHandler{
	
	// 채팅 페이지에 접속한 클라이언트 목록
	private ArrayList<WebSocketSession> clientList
					= new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅 페이지 접속");
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "c");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", "접속 했습니다.");
		for(WebSocketSession client : clientList) {
			client.sendMessage(new TextMessage(  new Gson().toJson(msgInfo)  ));
		}
		clientList.add(session);// 클라이언트 목록에 저장
		
		for(WebSocketSession client : clientList) { // A, B, C, D, E 5번반복
			Map<String, Object> clientAttrs = client.getAttributes();
			String clientMemberId = (String)clientAttrs.get("loginMemberId");
			
			HashMap<String, String> clientInfo = new HashMap<String, String>();
			clientInfo.put("msgtype", "c");
			clientInfo.put("msgid", clientMemberId);
			clientInfo.put("msgcomm", "접속 했습니다.");		
			session.sendMessage( new TextMessage( new Gson().toJson(clientInfo) ) );
		}
		
		
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("접속자가 메세지 전송");
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "m");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", message.getPayload());
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage(new TextMessage(  new Gson().toJson(msgInfo)  ));
			} 
		}
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅 페이지 접속해제");
		clientList.remove(session);// 클라이언트 목록에서 제거
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginMemberId = (String)sessionAttrs.get("loginMemberId");
		
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "d");
		msgInfo.put("msgid", loginMemberId);
		msgInfo.put("msgcomm", "접속을 해제 했습니다.");
		for(WebSocketSession client : clientList) {
			client.sendMessage(new TextMessage(  new Gson().toJson(msgInfo)  ));
		}		
		
	}

	
	
}
