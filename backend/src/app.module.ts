import { Module } from '@nestjs/common';
import { UsersController } from './controllers/users/users.controller';
import { UserService } from './services/user/user.service';
import { UserModule } from './modules/user/user.module';
import { AuthService } from './services/auth/auth.service';
import { AuthModule } from './modules/auth/auth.module';
import { PraiseService } from './services/praise/praise.service';
import { PrisesController } from './controllers/prises/prises.controller';

@Module({
  imports: [UserModule, AuthModule],
  controllers: [UsersController, PrisesController],
  providers: [UserService, AuthService, PraiseService],
})
export class AppModule {}
