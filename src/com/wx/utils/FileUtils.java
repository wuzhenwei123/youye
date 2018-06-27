package com.wx.utils;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.Kernel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

import javax.swing.ImageIcon;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class FileUtils {
	/**
	 * 
	 * @time : 2015年9月6日 下午6:23:56
	 * @param url
	 *            图片连接
	 * @param localPath
	 *            本机路径
	 * @Description: TODO
	 */
	public static boolean capt(String captPath, String url, String localPath, int width, int wait) {
		String commond = null;
		if (isLinux()) {
			commond = captPath + " --url=" + url + " --out=" + localPath + " --min-width=" + width + " --max-wait=" + wait;
			System.out.println("-------------------shell--------------"+commond);
		}else{
			commond = captPath + " --url=" + url + " --out=" + localPath + " --min-width=" + width + " --max-wait=" + wait;
			System.out.println("-------------------cmd--------------"+commond);
		}
		Process pro = null;
		try {
			pro = Runtime.getRuntime().exec(commond);
			pro.waitFor();
		} catch (IOException e) {
			return false;
		} catch (InterruptedException e) {
			return false;
		}
		return true;
	}
	
	public static boolean isLinux() {
		String osType = System.getProperties().getProperty("os.name").toLowerCase();
		if (osType.startsWith("windows")) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 
	 * @param toPath
	 *            保存路径
	 * @param sourcePath
	 *            源数据路径
	 */
	public static boolean downPic(String toPath, String sourcePath) {
		File file = new File(toPath);
		if (!file.exists()) {
			file.getParentFile().mkdirs();
		}
		try {
			URL url = new URL(sourcePath);
			URLConnection connection = url.openConnection();

			InputStream in = connection.getInputStream();
			OutputStream outputStream = new FileOutputStream(toPath);
			int i;
			while ((i = in.read()) != -1) {
				outputStream.write(i);
			}
			outputStream.flush();
			if (outputStream != null)
				outputStream.close();
			if (in != null)
				in.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	/**
	 * 
	 * @param toPath
	 *            保存路径
	 * @param sourcePath
	 *            源数据路径
	 */
	public static boolean downPic1(String toPath, String sourcePath) {
		File file = new File(toPath);
		if (!file.exists()) {
			file.getParentFile().mkdirs();
		}
		try {
//			URL url = new URL(sourcePath);
//			URLConnection connection = url.openConnection();
			FileInputStream in=new FileInputStream(sourcePath);//可替换为任何路径何和文件名
//			InputStream in = connection.getInputStream();
			OutputStream outputStream = new FileOutputStream(toPath);
			int i;
			while ((i = in.read()) != -1) {
				outputStream.write(i);
			}
			outputStream.flush();
			if (outputStream != null)
				outputStream.close();
			if (in != null)
				in.close();
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	/**
	 * 
	 * @param originalFile 输入文件
	 * @param resizedFile 输出文件
	 * @param newWidth 像素
	 * @param quality 质量  0f-1f
	 * @throws IOException
	 */
	public static void resize(File originalFile, File resizedFile,
			int newWidth, float quality) throws IOException {

		if (quality > 1) {
			throw new IllegalArgumentException(
					"Quality has to be between 0 and 1");
		}

		ImageIcon ii = new ImageIcon(originalFile.getCanonicalPath());
		Image i = ii.getImage();
		Image resizedImage = null;

		int iWidth = i.getWidth(null);
		int iHeight = i.getHeight(null);

		if (iWidth > iHeight) {
			resizedImage = i.getScaledInstance(newWidth, (newWidth * iHeight)
					/ iWidth, Image.SCALE_SMOOTH);
		} else {
			resizedImage = i.getScaledInstance((newWidth * iWidth) / iHeight,
					newWidth, Image.SCALE_SMOOTH);
		}

		// This code ensures that all the pixels in the image are loaded.
		Image temp = new ImageIcon(resizedImage).getImage();

		// Create the buffered image.
		BufferedImage bufferedImage = new BufferedImage(temp.getWidth(null),
				temp.getHeight(null), BufferedImage.TYPE_INT_RGB);

		// Copy image to buffered image.
		Graphics g = bufferedImage.createGraphics();

		// Clear background and paint the image.
		g.setColor(Color.white);
		g.fillRect(0, 0, temp.getWidth(null), temp.getHeight(null));
		g.drawImage(temp, 0, 0, null);
		g.dispose();

		// Soften.
		float softenFactor = 0.05f;
		float[] softenArray = { 0, softenFactor, 0, softenFactor,
				1 - (softenFactor * 4), softenFactor, 0, softenFactor, 0 };
		Kernel kernel = new Kernel(3, 3, softenArray);
		ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
		bufferedImage = cOp.filter(bufferedImage, null);

		// Write the jpeg to a file.
		FileOutputStream out = new FileOutputStream(resizedFile);

		// Encodes image as a JPEG data stream
		JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);

		JPEGEncodeParam param = encoder
				.getDefaultJPEGEncodeParam(bufferedImage);

		param.setQuality(quality, true);

		encoder.setJPEGEncodeParam(param);
		encoder.encode(bufferedImage);
	} // Example usage
}
