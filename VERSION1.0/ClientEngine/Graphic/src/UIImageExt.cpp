/*
 *  UIImageExt.mm
 *  DragonDrive
 *
 *  Created by jhzheng on 11-8-4.
 *  Copyright 2011 (����)DeNA. All rights reserved.
 *
 */

#include "UIImageExt.h"

// @implementation UIImage (grayscale)
// 
// typedef enum 
// {
// 	ALPHA = 0,
// 
// 	BLUE = 1,
// 
// 	GREEN = 2,
// 	 
// 	RED = 3
// }PIXELS;
// 
// - (UIImage *)convertToGrayscale {
// 	CCSize size = [self size];
// 
// 	int width = size.width;
// 	int height = size.height;
// 	// the pixels will be painted to this array
// 	uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
// 	// clear the pixels so any transparency is preserved
// 	memset(pixels, 0, width * height * sizeof(uint32_t));
// 	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
// 	// create a context with RGBA pixels
// 	CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, 
// 	kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
// 	// paint the bitmap to our context which will fill in the pixels array
// 	CGContextDrawImage(context, CCRectMake(0, 0, width, height), [self CGImage]);
// 	
// 	for(int y = 0; y < height; y++) {
// 		for(int x = 0; x < width; x++) {
// 			uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
// 			// convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
// 			uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
// 			// set the pixels to gray
// 			rgbaPixel[RED] = gray;
// 			rgbaPixel[GREEN] = gray;
// 			rgbaPixel[BLUE] = gray;
// 		}
// 	}
// 	
// 	// create a new CGImageRef from our context with the modified pixels
// 	CGImageRef image = CGBitmapContextCreateImage(context);
// 	// we're done with the context, color space, and pixels
// 	CGContextRelease(context);
// 	CGColorSpaceRelease(colorSpace);
// 	free(pixels);
// 	// make a new UIImage to return
// 	UIImage *resultUIImage = [UIImage imageWithCGImage:image];
// 	// we're done with image now too
// 	CGImageRelease(image);
// 	return resultUIImage;
// }
// 
// 
// // get sub image 
// - (UIImage*) getSubImageFromWithRect: (CCRect) rect 
// {
// 	UIGraphicsBeginImageContext(rect.size);
// 	CGContextRef context = UIGraphicsGetCurrentContext();
// 	// translated rectangle for drawing sub image
// 	CCRect drawRect = CCRectMake(-rect.origin.x, -rect.origin.y, self.size.width, self.size.height);
// 	// clip to the bounds of the image context
// 	// not strictly necessary as it will get clipped anyway?
// 	CGContextClipToRect(context, CCRectMake(0, 0, rect.size.width, rect.size.height));
// 	// draw image
// 	[self drawInRect:drawRect];
// 	// grab image
// 	UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
// 	UIGraphicsEndImageContext();
// 	return subImage;
// }
// @end