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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.sql.Date;

/**
 *
 * @author truon
 */

public class UpdateProfileServlet extends HttpServlet {
   
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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProfileServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        AccountDetail a = (AccountDetail) session.getAttribute("AccDetail");
        if (a == null) {
            request.setAttribute("ms", "message");
            request.setAttribute("message", "Session đã kết thúc. Vui lòng đăng nhập tài khoản.");
            request.getRequestDispatcher("Login").forward(request, response);
            return;
        }
        
        
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
        HttpSession session = request.getSession();
        AccountDetail a = (AccountDetail) session.getAttribute("AccDetail");
        if (a == null) {
            request.setAttribute("ms", "message");
            request.setAttribute("message", "Session đã kết thúc. Vui lòng đăng nhập tài khoản.");
            response.sendRedirect("Login");
            return;
        }
        String  newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        String newPhone = request.getParameter("phone");
        String newGender = request.getParameter("gender");
        String dob_raw = request.getParameter("dob");
        String ms = "";
        AccountDao acc= new AccountDao();
        
        try {
            Date dob = (dob_raw == null || dob_raw.equals(""))
                        ? null : Date.valueOf(dob_raw);
                boolean gender;
                if(newGender.equals("1")){
                   gender =true;
                }
                else{
                    gender= false;
                }
                boolean update = acc.editProfile( a.getAccountId(), gender, newPhone, dob, newName, newEmail);
                    if (update) {
                        ms = "Cập nhật hồ sơ thành công.";
                    } else {
                        ms = "Có lỗi xảy ra. Vui lòng thực hiên lại.";
                    }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } finally {
            request.setAttribute("msSuccess", ms);
            // Profile updated successfully
            
            AccountDetail b = acc.getAccountById(a.getAccountId(), getServletContext());
            session.setAttribute("AccDetail", b);
            session.setMaxInactiveInterval(4000);
            
            String message = "Bạn đã cập nhật thông tin thành công!";
           
            response.sendRedirect("Profile?accountId="+a.getAccountId()+"&page=1&message=" + URLEncoder.encode(message, "UTF-8"));
        }
    }

}
