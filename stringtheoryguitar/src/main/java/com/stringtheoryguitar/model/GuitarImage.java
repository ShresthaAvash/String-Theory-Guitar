// src/main/java/com/stringtheoryguitar/model/GuitarImage.java
package com.stringtheoryguitar.model;

import java.io.Serializable;
import jakarta.servlet.http.Part; 

public class GuitarImage implements Serializable {
    private static final long serialVersionUID = 1L;

    private int imageId;
    private int guitarId;
    private String imagePath; 
    private boolean isMainImage; 

    private transient Part filePart;

    public GuitarImage() {
    }

    public GuitarImage(int guitarId, String imagePath, boolean isMainImage) {
        this.guitarId = guitarId;
        this.imagePath = imagePath;
        this.isMainImage = isMainImage;
    }


    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getGuitarId() {
        return guitarId;
    }

    public void setGuitarId(int guitarId) {
        this.guitarId = guitarId;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public boolean isMainImage() {
        return isMainImage;
    }

    public void setMainImage(boolean mainImage) {
        isMainImage = mainImage;
    }

    public Part getFilePart() {
        return filePart;
    }

    public void setFilePart(Part filePart) {
        this.filePart = filePart;
    }

    @Override
    public String toString() {
        return "GuitarImage{" +
               "imageId=" + imageId +
               ", guitarId=" + guitarId +
               ", imagePath='" + imagePath + '\'' +
               ", isMainImage=" + isMainImage +
               '}';
    }
}