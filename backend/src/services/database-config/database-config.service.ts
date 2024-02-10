import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { User } from '../../entities/User';
import { Praise } from '../../entities/Praise';
import { Stamp } from '../../entities/Stamp';
import { Comment } from '../../entities/Comment';

@Injectable()
export class DatabaseConfigService {
  createTypeOrmOptions(): TypeOrmModuleOptions {
    const configService = new ConfigService();
    return {
      type: 'mysql',
      host: configService.get('DB_HOST'),
      port: configService.get('DB_PORT'),
      username: configService.get('DB_USERNAME'),
      password: configService.get('DB_PASSWORD'),
      database: configService.get('DB_DATABASE'),
      entities: [User, Praise, Stamp, Comment],
    };
  }
}
