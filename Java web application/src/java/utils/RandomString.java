/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;
import java.util.Random;
/**
 *
 * @author HP
 */
public class RandomString {
    public String getRandomPassword(){
        String uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowercaseLetters = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";

        String characters = uppercaseLetters + lowercaseLetters + numbers;

        Random random = new Random();

        // Tạo ký tự chữ hoa ngẫu nhiên
        char uppercaseChar = uppercaseLetters.charAt(random.nextInt(uppercaseLetters.length()));

        // Tạo ký tự chữ thường ngẫu nhiên
        char lowercaseChar = lowercaseLetters.charAt(random.nextInt(lowercaseLetters.length()));

        // Tạo ký tự số ngẫu nhiên
        char numberChar = numbers.charAt(random.nextInt(numbers.length()));

        // Tạo chuỗi ngẫu nhiên gồm 3 ký tự còn lại
        StringBuilder randomString = new StringBuilder();
        for (int i = 0; i < 3; i++) {
            char randomChar = characters.charAt(random.nextInt(characters.length()));
            randomString.append(randomChar);
        }

        // Ghép các ký tự lại thành chuỗi hoàn chỉnh
        String result = String.valueOf(uppercaseChar) + lowercaseChar + numberChar + randomString.toString();

        return result;
    }
    
    public String getRandomCode(){
        Random rd = new Random();
		String s1 = rd.nextInt(10) + "";
		String s2 = rd.nextInt(10) + "";
		String s3 = rd.nextInt(10) + "";
		String s4 = rd.nextInt(10) + "";
		String s5 = rd.nextInt(10) + "";
		String s6 = rd.nextInt(10) + "";
		
		String s =  s1+s2+s3+s4+s5+s6;
		return s;
    }
}
