package com.example.ASM2_JAV101_TH04864.ControllerProducts;

import com.example.ASM2_JAV101_TH04864.Entity.SanPham;

import com.example.ASM2_JAV101_TH04864.RepositoryProduct.RepoProduct;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Servlet_Products", value = {
        "/Load",
        "/Update",
        "/Delete",
        "/Fillter",
        "/Add"
})
public class ServletProduct extends HttpServlet {
    private final RepoProduct repoProduct = new RepoProduct();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("/Load")){
            String[] hang = {"KingStone", "SamSung","Seagate"};
            String[] listType = {"Phụ kiện", "Thiết bị"};
            req.setAttribute("hangSP", hang);
            req.setAttribute("listType", listType);
        List<SanPham> productList = repoProduct.getAll();

        req.setAttribute("productList", productList);

        req.getRequestDispatcher("/WEB-INF/view/productList.jsp").forward(req, resp);
        }else if(uri.contains("/Update")){
            String[] trangThai = {"Còn", "Hết"};
            String[] listType = {"Phụ kiện", "Thiết bị"};
            req.setAttribute("trangThai", trangThai);
            req.setAttribute("listType", listType);

            try {
                int id = Integer.parseInt(req.getParameter("id"));

                SanPham sp = repoProduct.findById(id);

                if (sp == null) {
                    req.setAttribute("error", "Không tìm thấy sản phẩm với ID = " + id);
                    req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
                    return;
                }

                req.setAttribute("sp",sp);

                System.out.println("Load sản phẩm cập nhật: ID=" + sp.getMaSP() +
                        ", Tên=" + sp.getTenSP() +
                        ", Giá=" + sp.getGiaSP());

                req.getRequestDispatcher("/WEB-INF/view/UpdateProduct.jsp").forward(req, resp);

            } catch (NumberFormatException e) {
                req.setAttribute("error", "ID sản phẩm không hợp lệ!");
                req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
            }
        }else if(uri.contains("/Add")){
            String[] trangThai = {"Còn", "Hết"};
            String[] listType = {"Phụ kiện", "Thiết bị"};
            req.setAttribute("trangThai", trangThai);
            req.setAttribute("listType", listType);
            req.getRequestDispatcher("/WEB-INF/view/AddProduct.jsp").forward(req,resp);
        }else if(uri.contains("/Delete")){
            Integer id = Integer.parseInt(req.getParameter("id"));
            repoProduct.delete(id);
            resp.sendRedirect(req.getContextPath()+"/Load");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        doGet(req, resp);
        String uri = req.getRequestURI();
        if(uri.contains("/Update")){
            Integer id = Integer.parseInt(req.getParameter("id"));
            String name = req.getParameter("ten");
            Float giaSP = Float.parseFloat(req.getParameter("giaSP"));
            Integer soluong = Integer.parseInt(req.getParameter("soluong"));
            boolean status = false;
            if(soluong >0){
                status = true;
            }else{
                status = false;
            }
            String hang = req.getParameter("hangSP");
            String loaiSP = req.getParameter("loaiSP");
            SanPham sp = new SanPham(id,name,giaSP,status,soluong,hang,loaiSP);
            repoProduct.update(sp);
            resp.sendRedirect(req.getContextPath()+"/Load");
        }else if(uri.contains("/Add")){
            String name = req.getParameter("ten");
            Float giaSP = Float.parseFloat(req.getParameter("giaSP"));
            boolean status = false;
            Integer soluong = Integer.parseInt(req.getParameter("soluong"));
            boolean trangthai = Boolean.parseBoolean(req.getParameter("trangthai"));
            if(soluong > 0){
                trangthai = true;
            }else{
                trangthai = false;
            }
            String loaiSP = req.getParameter("loaiSP");
            String hangSP = req.getParameter("hangSP");
            SanPham sp = new SanPham(name,giaSP,trangthai,soluong,loaiSP,hangSP);
            repoProduct.add(sp);
            resp.sendRedirect(req.getContextPath()+"/Load");
        }else if(uri.contains("/Fillter")){
            try {
                // Lấy tham số, xử lý null và rỗng
                String loaiSP = req.getParameter("loaiSP");
                String hangSP = req.getParameter("hang");
                String minPriceStr = req.getParameter("minprice");
                String maxPriceStr = req.getParameter("maxprice");

                float minPrice = minPriceStr == null || minPriceStr.trim().isEmpty() ? null : Float.parseFloat(minPriceStr);
                float maxPrice = maxPriceStr == null || maxPriceStr.trim().isEmpty() ? null : Float.parseFloat(maxPriceStr);

                List<SanPham> filteredList = repoProduct.filter(loaiSP, hangSP, minPrice, maxPrice);

                req.setAttribute("productList", filteredList);
                req.getRequestDispatcher("/WEB-INF/view/productList.jsp").forward(req, resp);
                resp.sendRedirect(req.getContextPath()+"/Load");

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("error", "Lỗi lọc sản phẩm: " + e.getMessage());
                req.setAttribute("productList", repoProduct.getAll()); // fallback
                req.getRequestDispatcher("/WEB-INF/view/productList.jsp").forward(req, resp);
            }
        }
    }
}
