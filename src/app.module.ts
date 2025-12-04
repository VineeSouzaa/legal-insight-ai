import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ReaderAI } from './services/readerAI';

@Module({
  imports: [ReaderAI],
  controllers: [AppController],
  providers: [AppService, ReaderAI],
})
export class AppModule {}
