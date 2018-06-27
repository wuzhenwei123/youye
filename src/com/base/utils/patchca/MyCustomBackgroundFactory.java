package com.base.utils.patchca;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Random;

import org.patchca.background.BackgroundFactory;

/**
 * 
 * 自定义验证码图片背景,主要画一些噪点和干扰线
 */

public class MyCustomBackgroundFactory implements BackgroundFactory {
	private static Random random = new Random();

	public void fillBackground(BufferedImage image) {
		Graphics graphics = image.getGraphics();
		// 验证码图片的宽高
		int imgWidth = image.getWidth();
		int imgHeight = image.getHeight();
		// 填充为白色背景
		graphics.setColor(Color.WHITE);
		graphics.fillRect(0, 0, imgWidth, imgHeight);
		// 画100个噪点(颜色及位置随机)
		for (int i = 0; i < 10; i++) {
			// 随机颜色
			int rInt = random.nextInt(255);
			int gInt = random.nextInt(255);
			int bInt = random.nextInt(255);
			graphics.setColor(new Color(rInt, gInt, bInt));
			// 随机位置
			int xInt = random.nextInt(imgWidth - 3);
			int yInt = random.nextInt(imgHeight - 2);
			// 随机旋转角度
			int sAngleInt = random.nextInt(360);
			int eAngleInt = random.nextInt(360);
			// 随机大小
			int wInt = random.nextInt(6);
			int hInt = random.nextInt(6);
			graphics.fillArc(xInt, yInt, wInt, hInt, sAngleInt, eAngleInt);
			// 画5条干扰线
			if (i % 20 == 0) {
				int xInt2 = random.nextInt(imgWidth);
				int yInt2 = random.nextInt(imgHeight);
				graphics.drawLine(xInt, yInt, xInt2, yInt2);
			}
		}
	}
}
