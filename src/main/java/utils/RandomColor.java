package utils;

import java.awt.Color;
import java.util.Random;


public class RandomColor {

    public static Color getColor() {
        Random r = new Random();
        Color randomColor = new Color(r.nextFloat(), r.nextFloat(), r.nextFloat());
        return randomColor;
    }

    public static Color getContrastColor(Color source) {
        return new Color(255 - source.getRed(), 255 - source.getGreen(), 255 - source.getBlue());
    }

}
