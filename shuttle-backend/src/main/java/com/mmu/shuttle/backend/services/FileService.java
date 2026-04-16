package com.mmu.shuttle.backend.services;


import com.mmu.shuttle.backend.exceptions.FileException;
import lombok.extern.slf4j.Slf4j;
import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;
import java.util.UUID;

import static java.nio.file.Files.readAllBytes;

@Slf4j
@Service
public class FileService {

    @Value("${storage.url}")
    private String storageUrl;

    public String uploadFile(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new FileException("File is empty or null");
        }

        try {
            validateImageSecurely(file);
            File folder = new File(storageUrl);
            if (!folder.exists()) {
                folder.mkdirs();
            }

            String originalFilename = Paths.get(Objects.requireNonNull(file.getOriginalFilename())).getFileName().toString();

            String safeFilename = UUID.randomUUID() + "_" + originalFilename;

            File destinationFile = new File(storageUrl + safeFilename);
            file.transferTo(destinationFile);

            return safeFilename;
        } catch (IllegalArgumentException e) {
            throw new FileException(e.getMessage());
        }
        catch (Exception e) {
            throw new FileException("Failed to upload file");
        }
    }

    public byte[] getFile(String fileName) {
        try {
            File file = new File(storageUrl + fileName);

            if (!file.exists()) {
                throw new FileException("File not found: " + fileName);
            }

            return readAllBytes(file.toPath());
        } catch (Exception e) {
            throw new FileException("Failed to read file");
        }
    }

    public void deleteFile(String fileName) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }

        try {
            Path filePath = Paths.get(storageUrl, fileName);
            File file = filePath.toFile();

            if (file.exists() && file.isFile()) {
                boolean isDeleted = file.delete();

                if (!isDeleted) {
                    // We just log it. See note below on why we don't throw an exception here.
                    log.warn("Warning: Could not delete orphaned file at " + filePath);
                }
            }
        } catch (Exception e) {
            // Log the error, but do not throw it
            log.error("Exception occurred while trying to delete file: " + e.getMessage(),e);
        }
    }


    public void validateImageSecurely(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File cannot be empty");
        }

        Tika tika = new Tika();

        String detectedType = tika.detect(file.getInputStream());

        if (!detectedType.startsWith("image/")) {
            throw new IllegalArgumentException("Security error: Uploaded file is not a valid image. Detected type: " + detectedType);
        }

        if (!detectedType.equals("image/jpeg") && !detectedType.equals("image/png") && !detectedType.equals("image/svg") && !detectedType.equals("image/jpg")) {
            throw new IllegalArgumentException("Only JPG and PNG files are supported.");
        }
    }
}
