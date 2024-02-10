import { Module } from '@nestjs/common';
import { UsersController } from './controllers/users/users.controller';
import { UserService } from './services/user/user.service';
import { UserModule } from './modules/user/user.module';
import { AuthService } from './services/auth/auth.service';
import { AuthModule } from './modules/auth/auth.module';

@Module({
  imports: [UserModule, AuthModule],
  controllers: [UsersController],
  providers: [UserService, AuthService],
})
export class AppModule {}
