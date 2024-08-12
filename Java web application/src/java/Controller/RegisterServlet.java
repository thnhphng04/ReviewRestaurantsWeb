/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.AccountDao;
import Model.AccountDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.sql.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import utils.Email;
import utils.Encoding;
import utils.RandomString;

/**
 *
 * @author HP
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String passwordRepeat = request.getParameter("passwordRepeat");
        String phone = request.getParameter("phone");
        int genderValue = Integer.parseInt(request.getParameter("gender"));
        boolean gender = (genderValue == 1); // True nếu giá trị là 1, False nếu giá trị là 0
        String dob = request.getParameter("dob");
        LocalDate localDate = null;
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            localDate = LocalDate.parse(dob, formatter);
        } catch (DateTimeParseException e) {
            request.setAttribute("err", "Invalid date format");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi LocalDate thành java.sql.Date
        Date dateOfBirth = Date.valueOf(localDate);
        RandomString rnd = new RandomString();
        // Tạo mã xác nhận ngẫu nhiên
        int verifyCode = Integer.parseInt(rnd.getRandomCode());

        Email e = new Email();
        AccountDao accDAO = new AccountDao();

        //check format gmail 
        String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        Pattern pattern = Pattern.compile(EMAIL_REGEX);
        Matcher matcher = pattern.matcher(email);
        //check password 
        String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z]).{6,}$";
        Pattern pattern1 = Pattern.compile(PASSWORD_REGEX);
        Matcher matcher1 = pattern1.matcher(password);

        //check sdt 
        String regex = "^0\\d{9}$";
        Pattern number = Pattern.compile(regex);
        Matcher matcher2 = number.matcher(phone);

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("err", "Hãy điền đầy đủ thông tin");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.getRequestDispatcher("Register.jsp").forward(request, response);

        } else if (!matcher.matches()) {
            request.setAttribute("err", "Email không đúng format");
            request.setAttribute("name", name);
            request.setAttribute("password", password);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } else if (!matcher1.matches()) {
            request.setAttribute("err", "Mật khẩu phải có cả chữ viết hoa,chữ viết thường, và có ít nhất 6 ký tự");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } else if (accDAO.checkEmail(email) != null) {

            request.setAttribute("err", "Email đã tồn tại");
            request.setAttribute("email", email);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } else if (!matcher2.matches()) {
            request.setAttribute("err", "Số điện thoại phải có 10 ký tự");
            request.setAttribute("name", name);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } else if (!password.equals(passwordRepeat)) {
            request.setAttribute("err", "Mật khẩu không trùng khớp");
            request.setAttribute("name", name);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        } else {
            password = Encoding.toSHA1(password);
            AccountDetail acc = new AccountDetail(password, gender, phone, dateOfBirth, name, email, 1, 0, verifyCode);
            accDAO.register(acc);
            request.setAttribute("err", "Succesful you can login");
            e.sendEmail(email, "here is your verify code: " + verifyCode);
            request.getRequestDispatcher("VerifyEmail.jsp?key_code=" + email).forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
