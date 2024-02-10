import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { Praise } from 'src/entities/Praise';
import { PraiseService } from 'src/services/praise/praise.service';
import { Stamp } from 'src/entities/Stamp';
import { User } from 'src/entities/User';
import { Comment } from 'src/entities/Comment';

@Module({
  imports: [TypeOrmModule.forFeature([Praise, User, Comment, Stamp])],
  providers: [PraiseService],
  exports: [PraiseService, TypeOrmModule],
})
export class PraiseModule {}
