import { Controller, Get, Post, Body, UploadedFile, UseInterceptors } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { AppService } from './app.service';
import * as pdfParse from 'pdf-parse';
import mammoth from 'mammoth';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('upload')
  @UseInterceptors(FileInterceptor('file'))
  async uploadFile(@UploadedFile() file: Express.Multer.File) {
    if (!file) {
      return { error: 'No file uploaded' };
    }
    const type = file.mimetype.split('/')[1];
    switch (type) {
      case 'pdf':
        const { text } = await pdfParse(file.buffer);
        return text;
      case 'docx':
        const { value } = await mammoth.convertToHtml(Buffer.from(file.buffer) as any);
        return value;
      default:
        return 'File type not supported';
    }
  }
}
