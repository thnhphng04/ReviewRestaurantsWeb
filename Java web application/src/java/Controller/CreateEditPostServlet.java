/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ImageDAO;
import DAL.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;

/**
 *
 * @author DELL
 */
@MultipartConfig
@WebServlet(name = "CreateEditPost", urlPatterns = {"/createEditPost"})
public class CreateEditPostServlet extends HttpServlet {

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
            out.println("<title>Servlet CreateEditPost</title>");
            out.println("</head>");
            out.println("<body>");
             out.println("<h1> success </h1>");

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
        String editOf = request.getParameter("editOfPostId");

        //save post
        String accountId = request.getParameter("accountId");
        String title = request.getParameter("title");
        String text = request.getParameter("text");
        String rating = request.getParameter("rating");

        String serviceRating = request.getParameter("serviceRating");
        String priceRating = request.getParameter("priceRating");
        String spaceRating = request.getParameter("spaceRating");
        String tasteRating = request.getParameter("tasteRating");
        String hygieneRating = request.getParameter("hygieneRating");

        String restaurantId = request.getParameter("restaurantId");

        PostDAO pd = new PostDAO();
        pd.hidePostForEditting(editOf);
        pd.insertEditPort(accountId, title, text, rating, restaurantId, serviceRating, priceRating, spaceRating, tasteRating, hygieneRating, editOf);

        String realPath = request.getServletContext().getRealPath("/images");

        String postId = String.valueOf(pd.getPostId());
        try {
            // Ensure the directory exists
            Path uploadPath = Path.of(realPath);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Process each uploaded file
            ImageDAO imd = new ImageDAO();
            for (Part part : request.getParts()) {
                if (part.getName().equals("files") && part.getSize() > 0) {
                    String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
                    if (filename != null && !filename.isEmpty()) {
                        part.write(uploadPath.resolve(filename).toString());

                        String filePath = uploadPath + "/" + filename;

                        imd.insertImage(postId, restaurantId, filePath);
                    }
                }
            }

            // Process proof images
            for (Part part : request.getParts()) {
                if (part.getName().equals("files2") && part.getSize() > 0) {
                    String filename = Path.of(part.getSubmittedFileName()).getFileName().toString();
                    if (filename != null && !filename.isEmpty()) {
                        part.write(uploadPath.resolve(filename).toString());

                        String filePath = uploadPath + "/" + filename;

                        imd.insertPostProofImage(postId, restaurantId, filePath);
                    }
                }
            }
        } catch (IOException | ServletException e) {
            e.printStackTrace(); // Print the stack trace to understand the root cause of the error
            // Handle the exception appropriately based on your application's error handling strategy
        }

        // Get and save selected meal types
        String[] mealTypes = request.getParameterValues("mealType");
        if (mealTypes != null) {
            for (int i = 0; i < mealTypes.length; i++) {
                pd.insertMealType(mealTypes[i], postId);
            }
        }

        // Get and save selected item types
        String[] foodTypes = request.getParameterValues("foodType");
        if (foodTypes != null) {
            for (int i = 0; i < foodTypes.length; i++) {
                pd.insertFoodType(foodTypes[i], postId);
            }
        }
        
        
        
        String message = "Bạn đã tạo bản chỉnh sửa thành công!";

        response.sendRedirect("PostPage?postId="+ editOf +"&message=" + URLEncoder.encode(message, "UTF-8"));
        
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
