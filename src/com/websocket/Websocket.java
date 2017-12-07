/**
 * 
 */
package com.websocket;

import java.io.IOException;
import java.util.concurrent.CopyOnWriteArraySet;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

/**
 * @author 彭普原
 * @date 2017年7月27日--下午2:27:27
 */
@ServerEndpoint("/websocket")
public class Websocket {

	private static CopyOnWriteArraySet<Websocket> websockets = new CopyOnWriteArraySet<>();

	private Session session;

	private Gson gson;

	@OnOpen
	public void open(Session session) {
		this.session = session;
		gson = new Gson();
		System.out.println(this);
		websockets.add(this);
		System.out.println("开启连接");
	}

	@OnClose
	public void close(Session session) {
		System.out.println("连接关闭");
	}

	@OnMessage
	public void message(Session session, String msg) {
		for (Websocket ws : websockets) {
			synchronized (Websocket.class) {
				if (!ws.equals(this)) {
					try {
						ws.session.getBasicRemote().sendText(msg);
					} catch (IOException e) {
						System.out.println("发送失败");
						websockets.remove(ws);
						try {
							ws.session.close();
						} catch (Exception f) {
							f.printStackTrace();
						}
					}
				}
			}
		}
	}
}
