import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { TypeOrmModuleOptions } from '@nestjs/typeorm';
import { User } from '../../entities/User';
import { Praise } from '../../entities/Praise';
import { Stamp } from '../../entities/Stamp';
import { Comment } from '../../entities/Comment';

@Injectable()
export class DatabaseConfigService {
  constructor(private configService: ConfigService) {}
  createTypeOrmOptions(): TypeOrmModuleOptions {
    return {
      type: 'mysql',
      host: this.configService.get('DB_HOST'),
      port: this.configService.get('DB_PORT'),
      username: this.configService.get('DB_USERNAME'),
      password: this.configService.get('DB_PASSWORD'),
      database: this.configService.get('DB_NAME'),
      entities: [User, Praise, Stamp, Comment],
    };
  }
}
